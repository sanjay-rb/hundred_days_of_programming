import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/how_controller.dart';

class HowView extends GetView<HowController> {
  const HowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How to do ?",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  "You can submit your task in five easy steps.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Stepper(
                    currentStep: controller.currentStep.value,
                    controlsBuilder: (context, details) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (controller.currentStep >= controller.totalStep)
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: const Text("Done"),
                            ),
                          if (controller.currentStep < controller.totalStep)
                            ElevatedButton(
                              onPressed: () {
                                controller.setCurrentStep(
                                  controller.currentStep.value + 1,
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: const Text("Next"),
                            ),
                          if (controller.currentStep > 0)
                            TextButton(
                              onPressed: () {
                                controller.setCurrentStep(
                                  controller.currentStep.value - 1,
                                );
                              },
                              child: Text(
                                "Previous",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          if (controller.currentStep > 0)
                            const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    connectorColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.secondary,
                    ),
                    onStepTapped: (value) => controller.setCurrentStep(value),
                    steps: <Step>[
                      Step(
                        title: Text(
                          'Step 1',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        subtitle: Text(
                          "Setting Up a GitHub Repository",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create a GitHub repository on your account named "100 Days of ABCD," where "ABCD" can be any programming language such as Python, Java, Dart, etc.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Follow the YouTube video below for instructions on creating the repository.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                String url =
                                    "https://youtu.be/x0EYpi38Yp4?si=rl09H5NuArNDqZ4m";
                                if (!await launchUrl(Uri.parse(url))) {
                                  LoggerService.error("Could not launch $url");
                                }
                              },
                              child: Text(
                                "GitHub Basics Tutorial - How to Use GitHub",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 0,
                      ),
                      Step(
                        title: Text(
                          'Step 2',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        subtitle: Text(
                          "Complete Today's Task.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create a script file in the cloned local GitHub repository.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Complete the current task and ensure that all test cases pass.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 1,
                      ),
                      Step(
                        title: Text(
                          'Step 3',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        subtitle: Text(
                          "Push to GitHub",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Once your code is ready, commit it and push it to the remote repository.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Follow the same YouTube video below for instructions on committing and pushing to the remote repository.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                String url =
                                    "https://youtu.be/x0EYpi38Yp4?si=rl09H5NuArNDqZ4m";
                                if (!await launchUrl(Uri.parse(url))) {
                                  LoggerService.error("Could not launch $url");
                                }
                              },
                              child: Text(
                                "GitHub Basics Tutorial - How to Use GitHub",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 2,
                      ),
                      Step(
                        title: Text(
                          'Step 4',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        subtitle: Text(
                          "Post on LinkedIn",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Share your successful completion of Day XX on LinkedIn, ensuring the following details are included.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "1. GitHub script URL",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '2. A screenshot of the "100 Days of Programming" application\'s Home Screen, showing the number of days you have completed and your current streak.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 3,
                      ),
                      Step(
                        title: Text(
                          ' Step 5',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        subtitle: Text(
                          "Mark as Completed",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Once you have both the GitHub script URL and the LinkedIn post URL, you are ready to complete the task in our application.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Please click the "Mark as Complete" button on the task page.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'You will be prompted to submit your GitHub script link and LinkedIn post link for verification.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Once you have provided the required details and submitted them, your task for the day is complete.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Enjoy your chai! You can start the next task after 24 hours.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep >= 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
