### how to use

```
import rpc

print ("\n\n test \n\n{0}".format(rpc.getinfo()))

print ("\ninfo:\n{0}".format(rpc.getinfo()))
print ("\naddress:\n{0}".format(rpc.getalladdress()))

print ("\ncheck address:\n{0}".format(rpc.checkAddress("XKPXK5NDUFYYCL46UKJCAMSGSCFAPMGZ")))
print ("\ncheck address:\n{0}".format(rpc.checkAddress("XKPXK5ND0FYYCL46UKJCAMSGSCFAPMGZ")))
print ("\ngetBalance:\n{0}".format(rpc.getbalance("XKPXK5NDUFYYCL46UKJCAMSGSCFAPMGZ")))
print ("\ngetmainbalance:\n{0}".format(rpc.getmainbalance()))
print ("\nlisttransactions:\n{0}".format(rpc.listtransactions()))

# bug
# print ("\nsendtoaddress:\n{0}".format(rpc.sendtoaddress("XKPXK5NDUFYYCL46UKJCAMSGSCFAPMGZ",10)))

# bug
#print ("\nminingStatus:\n{0}".format(rpc.miningStatus()))



print ("\ngetRoundInfo:\n{0}".format(rpc.getRoundInfo()))
```