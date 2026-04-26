# Dirac ACP Registry Entry

This directory contains the files required to register Dirac as an agent in the [Agent Client Protocol (ACP) registry](https://github.com/agentclientprotocol/registry), which enables integration with editors like Zed.

## Files
- `dirac/agent.json`: The agent configuration file.
- `dirac/icon.svg`: The Dirac icon.

## How to register Dirac in Zed
To add Dirac to the official ACP registry, follow these steps:

1. Fork the [agentclientprotocol/registry](https://github.com/agentclientprotocol/registry) repository.
2. Create a new directory named `dirac` in the root of the repository.
3. Copy `agent.json` and `icon.svg` from this directory into the `dirac` directory in your fork.
4. Submit a Pull Request to the `agentclientprotocol/registry` repository.

Once the PR is merged, Dirac will be available for discovery in Zed and other ACP-compatible editors.

## Manual Installation in Zed
If you want to test Dirac in Zed before it's officially registered:
1. Ensure you have `dirac-cli` installed: `npm install -g dirac-cli`
2. Open Zed's settings (`cmd-,` or `ctrl-,`).
3. Add Dirac to your `agents` configuration (refer to Zed's documentation for the exact format, as it may vary by version).
