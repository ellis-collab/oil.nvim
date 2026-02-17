local fs = require("oil.fs")

describe("fs", function()
  it("converts posix drive paths on windows", function()
    local old_is_windows = fs.is_windows
    fs.is_windows = true
    assert.equals("C:\\foo\\bar", fs.posix_to_os_path("/C/foo/bar"))
    fs.is_windows = old_is_windows
  end)

  it("does not treat multi-letter path prefixes as windows drives", function()
    local old_is_windows = fs.is_windows
    fs.is_windows = true
    assert.equals("/oil:/", fs.posix_to_os_path("/oil:/"))
    fs.is_windows = old_is_windows
  end)
end)
