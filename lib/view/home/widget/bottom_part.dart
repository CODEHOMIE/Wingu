import '../../../util/export_files.dart';

class BottomPart extends StatefulWidget {
  const BottomPart({super.key});

  @override
  State<BottomPart> createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      isScrollable: true,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      controller: _tabController,
                      indicatorColor: Colors.black,
                      labelStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                      unselectedLabelStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: 'today'.tr,
                        ),
                        Tab(
                          text: 'week'.tr,
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: Get.width,
                      color: Colors.grey.withOpacity(.4),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  bottomTile('Now', Images.sunnyIcon, '18°', 'Sun'.tr),
                  bottomTile('07:00', Images.sunIcon, '19°', 'Clouds'.tr),
                  bottomTile('08:00', Images.sunIcon, '20°', 'Clouds'.tr),
                  bottomTile('09:00', Images.windd, '20°', 'Wind'.tr),
                  bottomTile('10:00', Images.cloudIcon, '21°', 'Clouds'.tr)
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  bottomTile('Mon', Images.sunIcon, '20°', 'Clouds'.tr),
                  bottomTile('Tue', Images.windd, '20°', 'Wind'.tr),
                  bottomTile('Wed', Images.sunnyIcon, '18°', 'Sun'.tr),
                  bottomTile('Thur', Images.sunIcon, '19°', 'Clouds'.tr),
                  bottomTile('Fri', Images.cloudIcon, '21°', 'Clouds'.tr)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTile(
          String topStr, String iconStr, String bottomStr, String typeStr) =>
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topStr,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 11.0,
                ),
              ),
              Expanded(
                child: Image.asset(
                  iconStr,
                  height: 30,
                  width: 30,
                  color: Colors.black45,
                ),
              ),
              Text(
                bottomStr,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                typeStr,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      );
}
