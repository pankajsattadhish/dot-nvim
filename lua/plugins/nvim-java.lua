return {
  "nvim-java/nvim-java",

  config = function()
    require("java").setup({
      root_markers = {
        "settings.gradle",
        "settings.gradle.kts",
        "pom.xml",
        "build.gradle",
        "mvnw",
        "gradlew",
        "build.gradle.kts",
        ".git",
      },

      jdtls = {
        extendedClientCapabilities = require("java").extendedClientCapabilities,
      },

      lombok = {},

      java_test = {
        enable = true,
      },

      java_debug_adapter = {
        enable = true,
      },

      spring_boot_tools = {
        enable = true,
      },

      jdk = {
        auto_install = true, -- optional, safe to keep
      },

      -- REMOVE: notifications = { dap = true }, it breaks nvim-dap

      verification = {
        invalid_order = true,
        duplicate_setup_calls = true,
        invalid_mason_registry = false,
      },

      mason = {
        registries = {
          "github:nvim-java/mason-registry",
        },
      },
    })

    -- Auto LSP setup handled internally — no jdtls config needed
  end,
}
