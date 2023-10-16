part of 'read_page_cubit.dart';

sealed class ReadPageState extends Equatable {
  const ReadPageState();

  @override
  List<Object> get props => [];
}

final class ReadPageInitial extends ReadPageState {}

final class ReadPageLoading extends ReadPageState {}

