FROM node:20-slim

RUN apt-get update && apt-get install -y \
    bash curl git tmux jq \
    && rm -rf /var/lib/apt/lists/*

# Install Codex CLI
RUN npm install -g @openai/codex

RUN npm install -g --fetch-timeout=120000 --fetch-retries=5 @anthropic-ai/claude-code

# Install TinyClaw
RUN curl -fsSL https://raw.githubusercontent.com/jlia0/tinyclaw/main/scripts/remote-install.sh | bash

# Copy configs
COPY .tinyclaw/ /root/.tinyclaw/
COPY tinyclaw-workspace/ /root/tinyclaw-workspace/

# Env vars (set in Claw Cloud, not here)
ENV OPENAI_API_KEY=""
ENV DISCORD_TOKEN=""
ENV ANTHROPIC_API_KEY=""

CMD ["bash", "-c", "cd /root/.tinyclaw && tinyclaw start && tail -f /dev/null"]