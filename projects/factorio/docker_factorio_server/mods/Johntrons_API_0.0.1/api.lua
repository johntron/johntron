local function get_attributes(obj, attributes)
    local t = {}
    for _, attribute in pairs(attributes) do
        t[attribute] = obj[attribute]
    end
    return t
end

return {
    get_attributes = get_attributes
}