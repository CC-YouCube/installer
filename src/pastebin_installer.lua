--[[
_ _  _ ____ ___ ____ _    _    ____ ____
| |\ | [__   |  |__| |    |    |___ |__/
| | \| ___]  |  |  | |___ |___ |___ |  \

Github Repository: https://github.com/CC-YouCube
Homepage: https://youcube.madefor.cc/
License: GPL-3.0
]]
-- OpenPastebinInstaller v1.0.0 (based on wget)

local url_to_installer = "https://raw.githubusercontent.com/CC-YouCube/installer/main/src/installer.lua"

if not http then
    printError("OpenPastebinInstaller requires the http API")
    printError("Set http.enabled to true in ComputerCraft config")
    return
end

local function getFilename(url_to_file)
    return url_to_file:gsub("[#?].*", ""):gsub("/+$", ""):match("/([^/]+)$")
end

local function printColoured(text, colour)
    term.setTextColour(colour)
    print(text)
end

local function http_get(url)
    -- Check if the URL is valid
    local valid_url, error_message = http.checkURL(url)
    if not valid_url then
        printError(('"%s" %s.'):format(url, error_message or "Invalid URL"))
        return
    end

    printColoured(('Connecting to "%s" ... '):format(url), colors.lightGray)

    local response, http_error_message = http.get(url, nil, true)
    if not response then
        printError(('Failed to download "%s" (%s).'):format(url, http_error_message or "Unknown error"))
        return nil
    end

    local previous_colour = term.getTextColour()

    printColoured(('Runnig "%s".'):format(getFilename(url)), colors.lime)

    -- Reset colour
    term.setTextColour(previous_colour)

    local response_body = response.readAll()
    response.close()

    if not response_body then
        printError(('Failed to download "%s" (Empty response).'):format(url))
    end

    return response_body
end

local response_body = http_get(url_to_installer)

local loaded_function, load_error_message = load(response_body, getFilename(url_to_installer), "t", _ENV)
if not loaded_function then
    printError(load_error_message)
    return
end

local pcall_status, function_error_message = pcall(loaded_function)
if not pcall_status then
    printError(function_error_message)
end
