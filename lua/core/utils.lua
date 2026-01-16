local M = {}
-- This function gets LSP capabilities, including blink.cmp if available.
-- Used for setting up language servers consistently.
M.get_lsp_capabilities = function()
  local has_blink, blink = pcall(require, "blink.cmp")

  if has_blink and blink.get_lsp_capabilities then
    return vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      blink.get_lsp_capabilities(),
      {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      }
    )
  else
    return vim.lsp.protocol.make_client_capabilities()
  end
end

return M
