return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      {
        "<leader>aa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        desc = "Toggle AI chat",
      },
      {
        "<leader>aA",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        desc = "Add selection to chat",
      },
      {
        "<leader>ap",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        desc = "AI action palette",
      },
      {
        "<leader>ai",
        ":CodeCompanion ",
        mode = { "n", "v" },
        desc = "Inline AI edit (type instruction)",
      },
    },
    opts = {
      adapters = {
        http = {
          -- vLLM on the DGX Spark (OpenAI-compatible API, no key)
          abraxas = function()
            -- Keep a reference to openai_compatible's own message formatter
            local base_form_messages = assert(
              require("codecompanion.adapters.http.openai_compatible").handlers.form_messages,
              "codecompanion: openai_compatible form_messages handler not found (plugin API changed)"
            )

            return require("codecompanion.adapters").extend("openai_compatible", {
              formatted_name = "Abraxas (Qwen)",
              env = {
                url = "http://abraxas.local:8000",
                chat_url = "/v1/chat/completions",
                models_endpoint = "/v1/models",
              },
              schema = {
                model = { default = "qwen" }, -- vLLM's served model name
              },
              -- Qwen's chat template allows a single system message, first.
              -- codecompanion adds more (e.g. tool instructions), so merge them.
              handlers = {
                form_messages = function(self, messages)
                  local system, rest = {}, {}
                  for _, m in ipairs(messages) do
                    if m.role == "system" then
                      table.insert(system, m.content)
                    else
                      table.insert(rest, m)
                    end
                  end
                  if #system > 0 then
                    table.insert(
                      rest,
                      1,
                      { role = "system", content = table.concat(system, "\n\n") }
                    )
                  end
                  return base_form_messages(self, rest)
                end,
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = "abraxas" }, -- chat buffer (and agent tools)
        inline = { adapter = "abraxas" }, -- edits applied directly in the file
        cmd = { adapter = "abraxas" }, -- :CodeCompanionCmd (generate Ex commands)
      },
    },
  },
}
