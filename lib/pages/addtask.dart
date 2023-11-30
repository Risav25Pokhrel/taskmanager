import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/core/models/taskmodel.dart';
import 'package:taskmanager/core/services/http/serviceprovider.dart';
import 'package:taskmanager/pages/homepage.dart';
import 'package:taskmanager/widgets/commontextfield.dart';

class AddUpdatetask extends StatefulWidget {
  const AddUpdatetask({super.key, this.task, this.toUpdate = false});

  final Task? task;
  final bool toUpdate;

  @override
  State<AddUpdatetask> createState() => _AddUpdatetaskState();
}

class _AddUpdatetaskState extends State<AddUpdatetask> {
  final title = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    super.initState();
    title.text = widget.task?.title ?? '';
    description.text = widget.task?.description ?? '';
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = ValueNotifier<DateTime>(widget.task != null
        ? DateTime.fromMillisecondsSinceEpoch(widget.task!.onDate * 1000)
        : DateTime.now());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return ElevatedButton(
            onPressed: () async {
              final isValidate = formKey.currentState!.validate();
              if (!isValidate) {
                return;
              }
              final addupdate = ref.watch(taskService);

              if (widget.toUpdate) {
                widget.task!.title = title.text;
                widget.task!.description = description.text;
                widget.task!.onDate = date.value.millisecondsSinceEpoch;
                addupdate
                    .updateTask(widget.task!)
                    .then((value) => value ? Navigator.pop(context) : null);
                ref.invalidate(listTask);
              } else {
                final task = Task(
                  createdAt: DateTime.now().microsecondsSinceEpoch,
                  title: title.text,
                  description: description.text,
                  onDate: date.value.millisecondsSinceEpoch,
                  isImportant: false,
                  completed: false,
                );
                await addupdate
                    .addTasks(task.toJson())
                    .then((value) => value ? Navigator.pop(context) : null);
                ref.invalidate(listTask);
              }
            },
            child: Text(widget.toUpdate ? "Update" : "Add"),
          );
        },
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 10),
            Adaptextformfield(
              hinttext: "Title",
              controller: title,
              validator: (p0) =>
                  p0!.isEmpty ? "This Field Cannot be empty" : null,
            ),
            const SizedBox(height: 10),
            Adaptextformfield(
              hinttext: 'Description',
              controller: description,
              maxline: 5,
            ),
            Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: date,
                    builder: (context, value, child) =>
                        Text(formatdate(value))),
                IconButton(
                    onPressed: () {
                      chooseDate(context, date);
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            )
          ],
        ),
      ),
    );
  }
}

formatdate(dateTime) {
  final formattedDate = DateFormat('MMM d').format(dateTime);
  return formattedDate.toString();
}

chooseDate(context, ValueNotifier date) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 200,
        child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            minimumDate: DateTime.now(),
            maximumYear: DateTime.now().year,
            onDateTimeChanged: (value) => date.value = value),
      );
    },
  );
}
