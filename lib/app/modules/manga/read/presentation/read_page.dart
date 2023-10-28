import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/utils/toasting.dart';
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
  BoxFit boxFit = BoxFit.fitHeight;

  @override
  void initState() {
    super.initState();
    cubit.init(widget.cap['mangaID'], widget.cap['cap'].toString(), widget.cap['capList'], widget.cap['initial']);
  }

  String? cutInt(String? cap) {
    if (cap != null) {
      if (cap.endsWith('.0')) {
        return cap.substring(0, cap.length - 2);
      }
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    largura = context.width;
    altura = context.height;
    alturaContainer = 800;
    return BlocConsumer<ReadPageCubit, ReadPageState>(
      bloc: cubit,
      listener: (context, state) => {
        if (state is ReadPageWarning)
          {
            Toasting.warning(context, message: cubit.message),
          },
      },
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
                              // height: alturaContainer,
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
              bottom: 25,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey_600,
                  ),
                  // height: 75,
                  // width: context.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.cap['initial'] == true
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  Button(
                                    onPressed: () async {
                                      cubit.prevCap();
                                    },
                                    child: const Icon(Icons.arrow_left),
                                  ),
                                  const Gap(10),
                                  Button(
                                    onPressed: () async {
                                      cubit.nextCap();
                                    },
                                    child: const Icon(Icons.arrow_right),
                                  ),
                                  const Gap(10),
                                ],
                              ),
                        Button(
                          onPressed: () async {
                            // Modular.to.pop();
                            if (largura == context.width * 0.6) {
                              largura = context.width;
                              alturaContainer = 1500;
                              boxFit = BoxFit.fitHeight;
                            } else {
                              largura = context.width * 0.6;
                              alturaContainer = 980;
                              boxFit = BoxFit.fitHeight;
                            }
                            cubit.setState();
                          },
                          child: const Icon(
                            Icons.menu_book,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 20,
              left: 20,
              child: Align(
                alignment: Alignment.topLeft,
                child: Button(
                  onPressed: () async {
                    Modular.to.pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            Positioned.fill(
              top: 20,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black.withOpacity(0.5)),
                  child: Text('Cap: ${cutInt((cubit.capAtual!.btcCap! + 1.0).toString())}', style: const TextStyle(inherit: false, fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
