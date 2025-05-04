-- TODO: now that root_dir gains callback, we can
-- dynamically enable dartls by detecting valid dart binary.

local analysis_excluded_folders, flutter_sdk_root
local dart_bin = "dart"

local path_join = function(...) return table.concat({...}, "/") end

-- Path discovery performance is slow if searching downwards
-- so instead searching upward from the buffer path itself
if vim.fn.executable("fvm") == 1 then
    local buf_path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    local fvm_dir = vim.fs.find(".fvm", {
        path = buf_path,
        limit = 1,
        type = "directory",
        upward = true,
    })[1]

    if fvm_dir then
        flutter_sdk_root = vim.uv.fs_realpath(path_join(fvm_dir, "flutter_sdk"))
        dart_bin = path_join(flutter_sdk_root, "bin", "dart")
    end
elseif vim.fn.executable("flutter") == 1 then
    flutter_sdk_root = vim.fn.fnamemodify(vim.fn.exepath("flutter"), ":p:h:h")
    dart_bin = path_join(flutter_sdk_root, "bin", "dart")
end

if flutter_sdk_root then
    analysis_excluded_folders = {
        path_join(flutter_sdk_root, "packages"),
        path_join(flutter_sdk_root, ".pub-cache")
    }
end

return {
    cmd = { dart_bin, "language-server", "--protocol=lsp" },
    filetypes = { "dart" },
    root_markers = { "pubspec.yaml" },
    settings = {
        ["dart"] = {
            completeFunctionCalls = true,
            showTodos = false,
            updateImportsOnRename = true,
            analysisExcludedFolders = analysis_excluded_folders,
        },
    },
    init_options = {
        closingLabels = true,
        flutterOutline = true,
        outline = true,
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
    },
}
