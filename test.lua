local leveldb = require("resty.leveldb")
--local dogs = ngx.shared.dogs
--local db,flags = dogs:get("testdb")
print("set share mem db")
--end
local db = leveldb.reloaddb()
 function dobatch(key)
    print('start wirte')
    if db ==nil then 
         print("db is nil")
         db=leveldb.open("/opt/source/testdb",{error_if_exists=false})
    end
      db:put("a", "one")
      print('writed ok.')
      --leveldb.close()
      --print('closed ok.')
    
end

ngx.req.read_body()
local method = ngx.var.request_method

if method ~= 'GET' then
    ngx.say('pls. /=/leveldb only work as GET ;-)')
else
    local txt=ngx.var.arg_key
    local c=dobatch(key)
    ngx.say("jsoncallback("..txt..")")
end
