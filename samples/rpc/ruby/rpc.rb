require 'net/http'  
require 'uri'  
require 'json' 
class RPC
    def initialize(rpc_server)
        @@url = rpc_server
    end
    
    # 无需调用，这是内部函数
    def send_data(url,hash_data)  
        uri = URI(url)
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = hash_data.to_json
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req).body
        end
    end

    # 以下地址可调用

    # 得到基本信息
    def getinfo
        payload = Hash["method" => "getinfo", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    # 建议取消该功能，否则调用后，超级节点会出现错误，因为超级节点是单地址，不支持多地址。
    # def getnewaddress
    #     payload = Hash["method" => "getnewaddress", "params" => {},"jsonrpc" => "2.0","id" => 1]
    #     send_data(@@url,payload)
    # end

    # 得到所有地址   建议更改为 得到地址 ，参数需要变更为  getaddress
    def getalladdress
        payload = Hash["method" => "getalladdress", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    # 因为超级节点是单地址，因此建议用如下方法调用：
    # 注：此函数目前尚未被超级节点支持，需要主链团队支援，或社区开发者修复源码
    def getaddress
        payload = Hash["method" => "getaddress", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    # 以下函数因超级节点崩溃了没有进行测试，请开发者测试并提交bug

    def checkaddress(address)
        payload = Hash["method" => "checkAddress", "params" => {"address" => address},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def getbalance(address)
        payload = Hash["method" => "getbalance", "params" => {"address" => address},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def getmainbalance
        payload = Hash["method" => "getmainbalance", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def sendtoaddress(address,amount)
        payload = Hash["method" => "sendtoaddress", "params" => [address,amount],"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def miningStatus
        payload = Hash["method" => "miningStatus", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def getRoundInfo
        payload = Hash["method" => "getRoundInfo", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def unitInfo
        payload = Hash["method" => "unitInfo", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def badJoints
        payload = Hash["method" => "badJoints", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end

    def unhandleJoints
        payload = Hash["method" => "unhandleJoints", "params" => {},"jsonrpc" => "2.0","id" => 1]
        send_data(@@url,payload)
    end
end