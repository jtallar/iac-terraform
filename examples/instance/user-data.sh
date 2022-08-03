#!/bin/bash

cat > index.html <<EOF
<h1>Abajo esta el server text</h1>
<h1>${server_text}</h1>
EOF

python3 -m http.server ${server_port} &
