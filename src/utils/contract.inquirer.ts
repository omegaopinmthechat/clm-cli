import inquirer from "inquirer";

export async function selectContract(contractNames: string[]) {
  const answer = await inquirer.prompt([
    {
      type: "list",
      name: "contract",
      message: "Select contract to deploy:",
      choices: contractNames,
    },
  ]);

  return answer.contract;
}

export async function askConstructorParams(inputs: any[]) {
  const questions = inputs.map((input: any, index: number) => ({
    type: "input",
    name: `param${index}`,
    message: `Enter ${input.type} ${input.name || index}:`,
  }));

  const answers = await inquirer.prompt(questions);

  return inputs.map((input: any, i: number) => {
    let val: any = answers[`param${i}`];

    if (input.type.startsWith("uint") || input.type.startsWith("int")) {
      return Number(val);
    }

    if (input.type === "bool") {
      return val === "true";
    }

    return val;
  });
}
