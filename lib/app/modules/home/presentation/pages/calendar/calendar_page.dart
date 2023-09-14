import 'package:anime_app/app/core/common/constants/app_colors.dart';
import 'package:anime_app/app/core/common/extensions/color_extension.dart';
import 'package:anime_app/app/core/common/extensions/context_extension.dart';
import 'package:anime_app/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app/app/core/shared/anime/domain/entities/calendar_entity.dart';
import 'package:anime_app/app/core/shared/anime/presentation/components/calendar_item.dart';
import 'package:anime_app/app/modules/home/presentation/pages/calendar/cubit/calendar_cubit.dart';
import 'package:anime_app/app/ui/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  CalendarCubit cubit = Modular.get<CalendarCubit>();

  @override
  void initState() {
    var day = DateTime.now().weekday;
    tabController = TabController(length: 8, vsync: this, initialIndex: day == 7 ? 0 : day);

    cubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      bloc: cubit,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              child: Column(
                children: [
                  _buildTitle(),
                  _buildSubTitle(),
                  _buildTabBar(),
                  _buildTabView(state).expanded(),
                  // _buildTabView(),
                  // _buildAnimes(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTitle() => const Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppColors.grey_200,
                  size: 20,
                ),
                Gap(5),
                Text(
                  'Calendário',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildSubTitle() => const Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 0),
        child: Text(
          'Os horários e dias podem acabar variando conforme a fonte de lançamento acabe atrasando os mesmos.',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey_300),
          textAlign: TextAlign.center,
        ),
      );
  Widget _buildTabBar() => Container(
        width: context.width,
        padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 0),
        child: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          overlayColor: AppColors.pink_400.withOpacity(0.2).toMaterialStateProperty(),
          splashBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          indicator: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: AppColors.pink_400.withOpacity(1),
          ),
          tabs: const [
            Tab(text: 'Domingo'),
            Tab(text: 'Segunda'),
            Tab(text: 'Terça'),
            Tab(text: 'Quarta'),
            Tab(text: 'Quinta'),
            Tab(text: 'Sexta'),
            Tab(text: 'Sábado'),
            Tab(text: 'Indefinido'),
          ],
        ),
      );
  Widget _buildTabView(CalendarState state) => Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20, top: 0),
        child: TabBarView(
          controller: tabController,
          children: [
            if (state is CalendarLoading) ...[
              ...List.generate(
                8,
                (index) => const Center(
                  child: Loader(),
                ),
              ),
            ] else ...[
              _buildGridCalendarAnimes(cubit.calendar?.sunday),
              _buildGridCalendarAnimes(cubit.calendar?.monday),
              _buildGridCalendarAnimes(cubit.calendar?.tuesday),
              _buildGridCalendarAnimes(cubit.calendar?.wednesday),
              _buildGridCalendarAnimes(cubit.calendar?.thursday),
              _buildGridCalendarAnimes(cubit.calendar?.friday),
              _buildGridCalendarAnimes(cubit.calendar?.saturday),
              _buildGridCalendarAnimes(cubit.calendar?.undefined),
            ],
          ],
        ),
      );

  Widget _buildGridCalendarAnimes(List<CalendarAnimeEntity>? list) {
    var qtd = ((context.width - 40) / 210).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: qtd,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: list?.length ?? 0,
      itemBuilder: (_, index) => CalendarItem(anime: list![index]),
    );
  }
}
