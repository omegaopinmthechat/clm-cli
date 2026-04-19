import ora from "ora";

// Spinner functions
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

export function spinnerText(activity: string){
    spinner.text = `${activity}`;
}