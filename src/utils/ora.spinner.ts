import ora from "ora";

// export const spinner = ora("Compiling Solidity...").start();
let spinner: any;
export function spinnerStart(activity: string) {
  spinner = ora(activity).start();
}

export function spinnerSucceed(activity: string) {
  spinner.succeed(activity);
}

export function spinnerFailed(activity: string){
    spinner.fail(activity);
}