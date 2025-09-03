#!/bin/sh

ROOT=/root/.hydro

if [ ! -f "$ROOT/addon.json" ]; then
    echo '["@hydrooj/ui-default"]' > "$ROOT/addon.json"
fi

if [ ! -f "$ROOT/config.json" ]; then
    echo '{"host": "oj-mongo", "port": "27017", "name": "hydro", "username": "", "password": ""}' > "$ROOT/config.json"
fi

if [ ! -f "$ROOT/first" ]; then
    echo "for marking use only!" > "$ROOT/first"
    hydrooj cli user create Hydro@hydro.local hydro hydro123
    hydrooj cli user setPassword 1 hydro123
    hydrooj cli user setJudge 1
    hydrooj cli system set server.host 0.0.0.0
fi

pm2-runtime start hydrooj
