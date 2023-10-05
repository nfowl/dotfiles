{ config, pkgs, inputs, system, ... }:
{
	programs.helix.languages = {
		language = [
      {
        name = "typescript";
        auto-format = true;
        language-servers = [
          { name = "efm-prettier"; only-features = [ "format" ]; }
          { name = "typescript-language-server"; except-features = [ "format" ]; }
          { name = "eslint"; except-features = [ "format" ]; }
        ];
      }
      {
        name = "javascript";
        auto-format = true;
        language-servers = [
          { name = "efm-prettier"; only-features = [ "format" ]; }
          { name = "typescript-language-server"; except-features = [ "format" ]; }
          { name = "eslint"; except-features = [ "format" ]; }
        ];
      }
      {
        name = "html";
        auto-format = true;
        language-servers = [
          { name = "efm-prettier"; only-features = [ "format" ]; }
          "vscode-html-language-server"
        ];
      }
      {
        name = "css";
        auto-format = true;
        language-servers = [
          { name = "efm-prettier"; only-features = [ "format" ]; }
          "vscode-css-language-server"
        ];
      }
		];

		language-server = {
			eslint = {
				command = "vscode-eslint-language-server";
				args = ["--stdio"];
				config = { 
					format = true;
          nodePath = "";
          experimental.useFlatConfig = false;
          workingDirectory.mode = "location";
          codeAction = {
            disableRuleComment = {
              enable = true;
              location = "separateLine";
            };
            showDocumentation.enable = true;
          };
				};
			};
	    vscode-css-language-server.config.provideFormatter = false;
	    vscode-html-language-server.config.provideFormatter = false;
		};
	};
}
