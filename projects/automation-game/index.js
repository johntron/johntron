// class Inventory {
//   constructor() {
//     this.resources = {}
//   }
//
//   get current() {
//     return {
//       ...this.resources
//     };
//   }
//
//   updateFromWork(proof) {}
// }
//
// class ProofOfWork {
//   constructor(iteration, processor, producer, producedInventory) {}
// }
//
//
//
//



const recipes = {
  'iron ore': ['earth'],
  'iron': ['iron ore'],
  'gear': ['iron'],
};

class Machine {
  constructor(output) {
    this.output = output;
  }

  output(destination) {
    this.next = () => destination.run(this)
  }

  run(inputs) {
    const ingredients = recipes[this.output];

    if (!ingredients || !ingredients.every(ingredient => inputs[ingredient] > 0)) {
      console.error(`Cannot produce ${this.output} with ${JSON.stringify(inputs)}`);
      return inputs;
    }


    const outputs = ingredients.reduce((inventory, ingredient) => {
      inventory[ingredient] -= 1;
      return inventory;
    }, { ...inputs });

    outputs[this.output] = outputs[this.output] || 0;
    outputs[this.output] += 1;

    return outputs;
  }
}

const processOutput = (name, source, destination) => {
  this.name = name;
  source.output(name, destination);
}

class Factory {
  constructor(inventory) {
    this.inventory = inventory;
    this.iteration = 0;
  }

  iterate() {
    this.iteration += 1;
  }

  run(process) {
    console.log(`Starting ${process.name} with ${JSON.stringify(this.inventory)}.`)
    // Todo check that input is available in inventory
    this.iterate();
    const outputs = process.source.run(this.inventory);
    console.log(`Source machine produced ${process.source.output}`);

    this.inventory = process.destination.run(outputs);
    console.log(`Destination machine produced ${process.destination.output}`);

    console.log(`New inventory: ${JSON.stringify(this.inventory)}`);
  }
}

const miner = new Machine('iron ore');
const furnace = new Machine('iron');
const grinder = new Machine('gear');
processOutput('smelt', miner, furnace);
processOutput('grind', furnace, grinder);
const factory = new Factory({ 'earth': 1 });
factory.run(smelt);