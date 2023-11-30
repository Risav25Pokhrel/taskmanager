import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/core/configs/meta.dart';
import 'package:taskmanager/core/models/taskmodel.dart';
import 'package:taskmanager/core/services/http/serviceprovider.dart';
import 'package:taskmanager/core/services/http/taskmanager.dart';
import 'package:taskmanager/pages/addtask.dart';

import '../core/configs/appcolor.dart';

final listTask = FutureProvider((ref) => TaskOption(ref).getTasks());
final isGridview = ValueNotifier(false);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tasks"),
          actions: [
            ValueListenableBuilder(
                valueListenable: isGridview,
                builder: (context, value, child) => IconButton(
                    onPressed: () {
                      isGridview.value = !value;
                    },
                    icon: Icon(
                      value ? Icons.list : Icons.grid_view,
                    )))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddUpdatetask())),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final task = ref.watch(listTask);
            return RefreshIndicator.adaptive(
              onRefresh: () async => ref.invalidate(listTask),
              child: task.when(
                error: (error, stackTrace) => const Text("An Error Occur"),
                loading: () =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                data: (tasklist) {
                  return ValueListenableBuilder(
                    valueListenable: isGridview,
                    builder: (context, value, child) {
                      if (value) {
                        return GridView.builder(
                            itemCount: tasklist.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              final task = tasklist[index];
                              return FlipCard(
                                front: Card(
                                  margin: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(),
                                      borderRadius: BorderRadius.circular(10)),
                                  color: task.completed!
                                      ? AppColors.pink
                                      : Colors.indigoAccent.withOpacity(0.1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Spacer(flex: 3),
                                        Text(task.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(formatDate(task.onDate),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              IconButton(
                                                  onPressed: () {
                                                    if (task.completed!) {
                                                      Meta().messanger(
                                                          message:
                                                              "Task already completed");
                                                      return;
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  AddUpdatetask(
                                                                    task: task,
                                                                    toUpdate:
                                                                        true,
                                                                  )));
                                                    }
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {
                                                    showAlert(
                                                        context, ref, task);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                back: Card(
                                  margin: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(),
                                      borderRadius: BorderRadius.circular(10)),
                                  color:
                                      task.completed! ? AppColors.pink : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(task.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                          itemCount: tasklist.length,
                          itemBuilder: (context, index) {
                            final task = tasklist[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () => showMyModalSheet(context, task),
                                tileColor:
                                    task.completed! ? AppColors.pink : null,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10)),
                                title: Text(task.title),
                                subtitle: Text(
                                    "Status: ${task.completed! ? "Completed" : "Pending"}"),
                                titleTextStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                subtitleTextStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (task.completed!) {
                                              Meta().messanger(
                                                  message:
                                                      "Task already completed");
                                              return;
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AddUpdatetask(
                                                            task: task,
                                                            toUpdate: true,
                                                          )));
                                            }
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            showAlert(context, ref, task);
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}

showMyModalSheet(context, Task task) async {
  return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(task.title,
                    style: Theme.of(context).textTheme.headlineLarge),
                const Divider(),
                Text(task.description),
                const Spacer(),
                Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        final update = ref.watch(taskService);
                        task.completed = true;
                        await update.updateTask(task).then(
                            (value) => value ? Navigator.pop(context) : null);
                        ref.invalidate(listTask);
                      },
                      child: const Text("Completed"),
                    );
                  },
                )
              ],
            ),
          )));
}

formatDate(date) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
  final formattedDate = DateFormat('MMM d').format(dateTime);
  return formattedDate.toString();
}

showAlert(context, WidgetRef ref, task) {
  showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Are you sure to delete?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("cancel"),
              ),
              TextButton(
                onPressed: () {
                  final taskHttp = ref.watch(taskService);
                  Navigator.pop(context);
                  taskHttp
                      .deleteTasks(task.id)
                      .then((value) => value ? ref.invalidate(listTask) : null);
                },
                child: const Text("Ok"),
              )
            ],
          ));
}
