if [ "$SHLVL" = 1 ]; then
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

if [ -n "$SSH_AGENT_PID" ]; then
  kill $SSH_AGENT_PID
fi
