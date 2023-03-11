import 'package:bloc/bloc.dart';
import 'package:databaseflutter/data/data.dart';
import 'package:databaseflutter/data/repo/repository.dart';
import 'package:meta/meta.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final TaskEntity _task;
  final Repository<TaskEntity> repository;

  EditTaskCubit(this._task, this.repository) : super(EditTaskInitial(_task));

  void onSaveChangesClick() {
    repository.createOrUpdate(_task);
  }

  void onDeleteTaskClick(TaskEntity task){
    repository.delete(task);
  }

  void onTextChanged(String text) {
    _task.name = text;
  }

  void onPriorityChange(Priority priority) {
    _task.priority = priority;
    emit(EditTaskPriorityChange(_task));
  }
}
