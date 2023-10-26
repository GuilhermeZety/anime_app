import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/modules/manga/read/presentation/cubit/read_page_cubit.dart';
import 'package:anime_app/app/ui/components/button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key, required this.cap});

  final Map<String, dynamic> cap;

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  final ReadPageCubit cubit = ReadPageCubit();
  double? largura;
  double? altura;
  double? alturaContainer;
  BoxFit? boxFit;

  @override
  void initState() {
    super.initState();
    cubit.init(widget.cap['mangaID'], widget.cap['cap'].toString());
  }

  @override
  Widget build(BuildContext context) {
    largura = context.width;
    altura = context.height;
    alturaContainer = 800;
    return BlocBuilder<ReadPageCubit, ReadPageState>(
      bloc: cubit,
      builder: (context, state) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  if (cubit.listImages != null)
                    SizedBox(
                      width: largura,
                      height: altura,
                      child: ListView.builder(
                        itemCount: cubit.listImages!.length,
                        itemBuilder: (context, index) {
                          if (cubit.listImages![index].endsWith('.avif')) {
                            return Container(
                              color: AppColors.grey_200,
                              height: alturaContainer,
                              // width: context.width,
                              child: AvifImage.network(
                                cubit.listImages![index],
                                fit: boxFit,
                                // fit: BoxFit.fitWidth,
                                // width: largura,
                                // cacheWidth: largura?.toInt(),
                                // cacheHeight: altura?.toInt(),
                                // cacheWidth: largura?.toInt(),
                                // height: altura,
                                // width: largura,
                              ),
                            );
                          } else {
                            return CachedNetworkImage(
                              imageUrl: cubit.listImages![index],
                              fit: BoxFit.fitHeight,
                              placeholder: (context, url) => SizedBox(
                                height: altura,
                                width: largura,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ), // Exemplo de placeholder
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                              ), // Exemplo de widget de erro
                            );
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            Positioned.fill(
              bottom: 75,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey_600,
                  ),
                  // height: 75,
                  width: context.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          onPressed: () async {
                            Modular.to.pop();
                          },
                          child: const Icon(Icons.close),
                        ),
                        const Gap(10),
                        Button(
                          onPressed: () async {
                            // Modular.to.pop();
                            if (largura == context.width * 0.6) {
                              largura = context.width;
                              alturaContainer = 1500;
                              boxFit = BoxFit.cover;
                            } else {
                              largura = context.width * 0.6;
                              alturaContainer = 980;
                              boxFit = BoxFit.fitHeight;
                            }
                            cubit.setState();
                          },
                          child: const Icon(Icons.settings),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
