SECP256K1_p = (
    0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f
)
SECP256K1_a = (
    0x0000000000000000000000000000000000000000000000000000000000000000
)
SECP256K1_b = (
    0x0000000000000000000000000000000000000000000000000000000000000007
)
SECP256K1_xG = (
    0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798
)
SECP256K1_yG = (
    0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
)
SECP256K1_G = SECP256K1_xG, SECP256K1_yG
SECP256K1_n = (
    0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
)
SECP256K1_h = 1
SECP256K1_point_at_infinity = None


def sha256(msg):
    assert type(msg) is bytes
    import hashlib

    return hashlib.sha256(msg).digest()


def sha512(msg):
    assert type(msg) is bytes
    import hashlib

    return hashlib.sha512(msg).digest()


def hmacsha256(key, msg):
    assert type(key) is bytes
    assert type(msg) is bytes
    import hmac

    return hmac.new(key, msg, "sha256").digest()


def hmacsha512(key, msg):
    assert type(key) is bytes
    assert type(msg) is bytes
    import hmac

    return hmac.new(key, msg, "sha512").digest()


def pbkdf2_hmacsha512_2048_64(password, salt):
    assert type(password) is bytes
    assert type(salt) is bytes
    import hashlib

    return hashlib.pbkdf2_hmac(
        hash_name="sha512",
        password=password,
        salt=salt,
        iterations=2048,
        dklen=64,
    )


def neg(P):
    assert _is_a_valid_EC_point(P)
    if P is SECP256K1_point_at_infinity:
        return P
    x, y = P
    return x, ((-y) % SECP256K1_p)


def add(P1, P2):
    assert _is_a_valid_EC_point(P1)
    assert _is_a_valid_EC_point(P2)
    if P1 is SECP256K1_point_at_infinity:
        return P2
    if P2 is SECP256K1_point_at_infinity:
        return P1
    if P1 != P2:
        return _add(P1, P2)
    if P1 == P2 and P1 != neg(P1):
        return _dbl(P1)
    if P1 == P2 and P1 == neg(P1):
        return SECP256K1_point_at_infinity


def mul(k, P):
    k = k % SECP256K1_n
    R = SECP256K1_point_at_infinity
    for s in bin(k)[2:]:
        R = add(R, R)
        if s == "1":
            R = add(R, P)
    return R


def _add(P1, P2):
    x1, y1 = P1
    x2, y2 = P2
    v = ((y2 - y1) * _inv_mod_p(x2 - x1)) % SECP256K1_p
    x3 = (v * v - x1 - x2) % SECP256K1_p
    y3 = (v * (x1 - x3) - y1) % SECP256K1_p
    return x3, y3


def _dbl(P1):
    x1, y1 = P1
    w = ((3 * x1 * x1 + SECP256K1_a) * _inv_mod_p(2 * y1)) % SECP256K1_p
    x4 = (w * w - 2 * x1) % SECP256K1_p
    y4 = (w * (x1 - x4) - y1) % SECP256K1_p
    return x4, y4


def _inv_mod_p(x):
    return pow(x, SECP256K1_p - 2, SECP256K1_p)


def _inv_mod_n(x):
    return pow(x, SECP256K1_n - 2, SECP256K1_n)


def _is_a_valid_EC_point(P):
    if P is SECP256K1_point_at_infinity:
        return True
    if not (type(P) is tuple and len(P) == 2):
        return False
    x, y = P
    if not (type(x) is int and 0 <= x <= SECP256K1_p - 1):
        return False
    if not (type(y) is int and 0 <= y <= SECP256K1_p - 1):
        return False
    return (
        0
        == (pow(x, 3, SECP256K1_p) + SECP256K1_a * x + SECP256K1_b - y ** 2)
        % SECP256K1_p
    )


def _sqrt(qr, m):
    sr = pow(qr, (m + 1) >> 2, m)
    if sr % 2 == 0:
        return sr, m - sr
    else:
        return m - sr, sr


def _get_two_possible_y_for_x(x):
    assert type(x) is int and 0 <= x <= SECP256K1_p - 1
    y_squared = (
        pow(x, 3, SECP256K1_p) + SECP256K1_a * x + SECP256K1_b
    ) % SECP256K1_p
    y0, y1 = _sqrt(y_squared, SECP256K1_p)
    assert pow(y0, 2, SECP256K1_p) == y_squared
    return y0, y1


def _rfc6979_csprng_sha256_secp256k1(entropy):
    V = b"\x01" * 32
    K = b"\x00" * 32
    K = hmacsha256(K, V + b"\x00" + entropy)
    V = hmacsha256(K, V)
    K = hmacsha256(K, V + b"\x01" + entropy)
    V = hmacsha256(K, V)
    while True:
        T = hmacsha256(K, V)
        k = int.from_bytes(T, "big")
        if 0 < k < SECP256K1_n:
            yield k
        K = hmacsha256(K, V + b"\x00")
        V = hmacsha256(K, V)


def _ecdsa_sign_core(d, k, e):
    # input
    #     long-term key pair      (d, (xQ, yQ)) randomly generated
    #     ephemeral key pair      (k, (xR, yR)) randomly generated with xR != 0 && xR != n && xR != -e/d
    #     message digest          e
    # output
    #     signature               (r, s)    with r = xR and s = (r * d + e) / k
    #     recovery id             t         the least significant bit of yR
    assert type(d) is int and 1 <= d <= SECP256K1_n - 1
    assert type(k) is int and 1 <= k <= SECP256K1_n - 1
    assert type(e) is int and 0 <= e <= SECP256K1_n - 1
    long_term_pubkey = mul(d, SECP256K1_G)
    ephemeral_pubkey = mul(k, SECP256K1_G)
    xR, yR = ephemeral_pubkey
    if not (1 <= xR <= SECP256K1_n - 1 and (xR * d + e) % SECP256K1_n != 0):
        raise ValueError
    r = xR
    s = ((r * d + e) * _inv_mod_n(k)) % SECP256K1_n
    if s <= ((SECP256K1_n - 1) // 2):
        return r, s, (yR & 1)
    else:
        return r, (SECP256K1_n - s), (1 - (yR & 1))  # XXX


def ecdsa_sign(private_key, hashed_data):
    """
    Returns (r, s, t) where
    r is a positive integer <= (SECP256K1_n-1),
    s is a positive integer <= ((SECP256K1_n-1)/2), and
    t is either 0 or 1
    """
    assert type(private_key) is int and 1 <= private_key <= SECP256K1_n - 1
    assert type(hashed_data) is bytes and len(hashed_data) == 32
    d = private_key
    e = int.from_bytes(hashed_data, "big") % SECP256K1_n
    for k in _rfc6979_csprng_sha256_secp256k1(
        d.to_bytes(32, "big") + e.to_bytes(32, "big")
    ):
        try:
            r, s, t = _ecdsa_sign_core(d, k, e)
            return r, s, t
        except ValueError:
            continue


def _ecdsa_recover_public_key(e, r, s, t):
    assert type(e) is int and 0 <= e <= SECP256K1_n - 1
    assert type(r) is int and 1 <= r <= SECP256K1_n - 1
    assert type(s) is int and 1 <= s <= SECP256K1_n - 1
    assert type(t) is int and t in {0, 1}
    xR = r
    yR = _get_two_possible_y_for_x(xR)[t]
    R = xR, yR
    return mul(
        pow(r, SECP256K1_n - 2, SECP256K1_n),
        add(mul(s, R), neg(mul(e, SECP256K1_G))),
    )


def ecdsa_recover(hashed_data, r, s, t):
    assert type(hashed_data) is bytes and len(hashed_data) == 32
    assert type(r) is int and 1 <= r <= SECP256K1_n - 1
    assert type(s) is int and 1 <= s <= SECP256K1_n - 1
    assert type(t) is int and t in {0, 1}
    e = int.from_bytes(hashed_data, "big") % SECP256K1_n
    Q = _ecdsa_recover_public_key(e, r, s, t)
    return Q
