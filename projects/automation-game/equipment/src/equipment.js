const recipes = {
  'iron ore': ['earth'],
  'iron': ['iron ore'],
  'gear': ['iron'],
};

const hasIngredients = (input, desiredOutput) => {
  return recipes[desiredOutput] && recipes[desiredOutput].every(ingredient => input[ingredient] > 0);
}

module.exports = (input, desiredOutput = input) => {
  if (!hasIngredients(input, desiredOutput)) {
    console.error(`Cannot produce ${desiredOutput} with ${JSON.stringify(input)}`);
    return input;
  }

  return desiredOutput
}