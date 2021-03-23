import 'package:Plant_shop_ui/models/plant.dart';
import 'package:Plant_shop_ui/screens/plant_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  var _selectedPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _tabController = TabController(length: 5, vsync: this);
    _pageController = PageController(viewportFraction: 0.8);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 60),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 30.0,
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Top Picks',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.6),
                labelPadding: EdgeInsets.symmetric(horizontal: 35),
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Top',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Outdoor',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Indoor',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'New Arrivals',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Limited Edition',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 500,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _selectedPage = index;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (ctx, i) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (ctx, widget) {
                        double value = 1;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page - i;

                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }
                        return Center(
                          child: SizedBox(
                            height: Curves.easeInOut.transform(value) * 500,
                            width: Curves.easeInOut.transform(value) * 400,
                            child: widget,
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => PlantDetails(
                                plant: plants[i],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF32A060),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Hero(
                                        tag: plants[i].imageUrl,
                                        child: Image(
                                          height: 280,
                                          width: 280,
                                          image: AssetImage(
                                              'assets/images/plant$i.png'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Positioned(
                                    right: 30,
                                    top: 30,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'FROM',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '\$${plants[i].price}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 30,
                                    bottom: 30,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${plants[i].category}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${plants[i].name}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              child: RawMaterialButton(
                                onPressed: () => print('clicked'),
                                padding: EdgeInsets.all(15),
                                shape: CircleBorder(),
                                fillColor: Colors.black,
                                child: Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: plants.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 20,
                    ),
                    Text('${plants[_selectedPage].description}',
                        style: TextStyle(fontSize: 16, color: Colors.black87)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
