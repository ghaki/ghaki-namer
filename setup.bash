export GK_PROJECT_IDEPS=( \
  "$(pwd)/../ghaki-app/lib" \
  )
export GK_PROJECT_GO_DIRS=( \
  "lib:${GK_PROJECT_DIR}/lib/ghaki/namer" \
  "spec:${GK_PROJECT_DIR}/spec/ghaki/namer " \
  )

rvm use '1.9.2@ghaki-namer'
