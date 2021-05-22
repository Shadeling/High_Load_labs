counter = 0

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"

request = function()
   path = "/person"
   wrk.body = "last_name=Mironov&first_name=Slav&age=22&login=mir@" .. counter
   counter = counter + 1
   return wrk.format(nil, path)
end
