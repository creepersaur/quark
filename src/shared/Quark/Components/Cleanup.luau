local Created

local Cleanup = function()
    for _,v in Created do
        if v:IsA("Instance") then
            v:Destroy()
        else
            v:Disconnect()
        end
    end
end

local SetCreated = function(c: {}, a: {})
    Created = c
    for _, v in a do
        table.insert(Created, a)
    end
end

return {
    Cleanup,
    SetCreated
}