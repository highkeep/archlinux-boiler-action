
# ArchLinux Boiler Action
Arch Linux based Docker boilerplate for actions.

- Mainly here for me to clone, wipe and reuse. 
- Included examples to make my life easier.

## Example workflow:

```yaml
name: boil

on:
  workflow_dispatch:

jobs:
  package: 
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Random Run
        id: randomRun
        uses: highkeep/archlinux-boiler-action@main
        with:
          someInputName: anInputName
          someOtherInputName: anotherInputName
          multipleInputs: 1 2 3 4 5
      - name: Random In
        uses: highkeep/archlinux-boiler-action@main
        with:
          multipleInputs: ${{ steps.randomRun.outputs.multipleOutputs }}
```

