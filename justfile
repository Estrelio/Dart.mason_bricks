bootstrap:
    melos bootstrap

bump-dependencies:
    melos exec -- dart pub upgrade --major-versions --tighten --unlock-transitive
