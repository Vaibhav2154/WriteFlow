import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onUploadBlog);
  }

  void _onUploadBlog(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(UploadBlogParams(
      title: event.title,
      posterId: event.posterId,
      content: event.content,
      image: event.image,
      topics: event.topics,
    ));
    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(
        BlogSuccess(),
      ),
    );
  }
}
