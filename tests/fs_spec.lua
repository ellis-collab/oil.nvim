local fs = require("oil.fs")

---@param cb fun()
local function with_windows(cb)
  local old_is_windows = fs.is_windows
  fs.is_windows = true
  local ok, err = pcall(cb)
  fs.is_windows = old_is_windows
  assert(ok, err)
end

describe("fs", function()
  it("converts posix drive paths on windows", function()
    with_windows(function()
      assert.equals("C:\\foo\\bar", fs.posix_to_os_path("/C/foo/bar"))
    end)
  end)

  it("does not treat multi-letter path prefixes as windows drives", function()
    with_windows(function()
      assert.equals("/oil:/", fs.posix_to_os_path("/oil:/"))
    end)
  end)
end)
