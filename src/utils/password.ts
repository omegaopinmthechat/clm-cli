import inquirer from "inquirer";

interface ResolvePasswordOptions {
  providedPassword?: string;
  requireConfirmation?: boolean;
  message?: string;
  confirmationMessage?: string;
}

export async function resolvePassword(
  options: ResolvePasswordOptions = {},
): Promise<string> {
  const providedPassword = options.providedPassword?.trim();

  if (providedPassword) {
    return providedPassword;
  }

  const { password } = await inquirer.prompt([
    {
      type: "password",
      name: "password",
      message: options.message ?? "Enter password",
      mask: "*",
      validate: (value: string) =>
        value.trim().length > 0 || "Password cannot be empty",
    },
  ]);

  if (options.requireConfirmation) {
    const { confirmPassword } = await inquirer.prompt([
      {
        type: "password",
        name: "confirmPassword",
        message: options.confirmationMessage ?? "Confirm password",
        mask: "*",
      },
    ]);

    if (password !== confirmPassword) {
      throw new Error("Password confirmation does not match.");
    }
  }

  return password;
}