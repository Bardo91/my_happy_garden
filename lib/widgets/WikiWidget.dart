import 'package:flutter/material.dart';

class WikiEntry{
  WikiEntry({required this.imagePath, required this.title, required this.description});
  String imagePath;
  String title;
  String description;
}

List<WikiEntry> entries = [
  WikiEntry(imagePath: "assets/images/wiki/tomatera.jpg", title: "Solanum lycopersicum", description: "Es una planta herbácea anual o perenne. El tallo es erguido y cilíndrico en la planta joven; a medida que ésta crece, el tallo cae y se vuelve anguloso, presenta vellosidades en la mayor parte de sus órganos y glándulas que segregan una sustancia de color verde aromática, puede llegar a medir hasta 2,50 m, ramifica de forma abundante y tiene yemas axilares. Si al final del crecimiento todas las ramificaciones exhiben yemas reproductivas, estas se clasifican como de crecimiento determinado y si terminan con yemas vegetativas, son clasificadas como de crecimiento indeterminado.6​7​  Las hojas son compuestas, se insertan sobre los diversos nudos en forma alterna. El limbo se encuentra fraccionado en siete, nueve y hasta once folíolos. El haz es de color verde y el envés de color grisáceo. En tomates más rústicos el tamaño de sus hojas es más pequeño. La disposición de nervaduras en los folíolos es penninervia.8​6​  Presenta inflorescencias que pueden ser de cuatro tipos: racimo simple, cima unípara, bípara y multípara; pudiendo llegar a tener hasta 50 flores por racimo.8​ La flor está formada por un pedúnculo corto, el cáliz tiene los sépalos soldados entre sí, al igual que la corola con los pétalos. El androceo tiene cinco o más estambres adheridos a la corola con las anteras que forman un tubo. Las anteras son poricidas, en vez de dehiscentes y por esto requieren polinización por zumbido. El gineceo presenta de dos a treinta carpelos que al desarrollarse darán origen a los lóculos o celdas del fruto.7​ Las flores son hermafroditas. El cáliz está compuesto de cinco sépalos y la corola de cinco pétalos amarillos (ocasionalmente seis). Los estambres, se reúnen formando un tubo alrededor del gineceo. El estilo es más corto o tan largo como los estambres; posición que favorece considerablemente la autopolinización.9​  El fruto es una baya de color rojo bajo en caseína, cuyo tamaño es variable, desde 3 cm de diámetro hasta 16 cm, con semillas dentro de un pericarpio carnoso desarrollado de un ovario. Su forma puede ser redondeada, achatada o en forma de pera y su superficie lisa o asurcada. La semilla es de diferentes tonalidades en su color, desde el grisáceo, hasta el color paja de forma oval aplastada; tamaño entre 3 y 5 mm de diámetro y 2,5 mm de longitud, y cubierta de vellosidades y están embebidas en una abundante masa mucilaginosa. La raíz, que es pivotante, alcanza hasta 1,5 m de profundidad"),
  WikiEntry(imagePath: "assets/images/wiki/pimiento.jpg", title: "Capsicum", description: "Son plantas arbustivas, anuales o perennes que pueden alcanzar 4 m de altura, aunque la mayoría no llega a los 2 m. Tienen tallos ramificados glabros o con pubescencia rala. Las hojas, de 4-12 cm de largo, son solitarias u opuestas, pecioladas y con los limbos simples enteros o sinuados. Las flores actinomorfas y hermafroditas, o las inflorescencias, axilares y sin pedúnculos, nacen en los nudos de las hojas con el tallo. Son erectas o péndulas. Tienen normalmente 5 sépalos en un cáliz persistente acampanado y denticulado, ocasionalmente acrescente en el fruto, y habitualmente 5 —y desde 4 hasta muchos en cultivares— pétalos de color blanco, amarillo, azul, violeta más o menos intenso, moteado de verde o francamente bicolor. Los estambres, soldados a la corola, tienen las anteras amarillas o purpúreas, de forma ovoide y dehiscente longitudinalmente. Su ovario es súpero, bi o tri-carpelar incluso más, con numerosos óvulos, y el estilo es fino con un estigma pequeño y cabezudo. El fruto, erecto o péndulo, es una baya de tipo carnoso hueca, siempre verde, más o menos oscuro, cuando inmaduro y que se torna de color amarillo-anaranjado-rojo vivo - y hasta violeta - al madurar; sin embargo unas especies salvajes de Brasil no cambian de color al madurar, y se quedan verdes. Curiosamente, o quizás por esto, estas especies tienen 26 cromosomas en lugar del habitual 24 para las especies domesticadas.2​ Tiene interiormente tabiques generalmente incompletos —concurriendo hacia el eje en la base del fruto— en los cuales se insertan las semillas, sobre todo en la zona axial, engrosada, de convergencia. Dichos frutos pueden tener hasta unos 15 cm de largo, y son de forma muy diversa, desde globulares hasta estrechamente cónicos. Las simientes, que pueden conservarse unos 3 años en condiciones favorables, son amarillentas y hasta negruzcas; tienen forma discoidal algo espiralada, de perfil muy aplanado, con finísimos sillones concéntricos crenulados y miden unos mm de diámetro. El embrión tiene forma de tubo enrollado")
];

class WikiWidget extends StatefulWidget {
  const WikiWidget({ Key? key }) : super(key: key);

  @override
  _WikiWidgetState createState() => _WikiWidgetState();
}

class _WikiWidgetState extends State<WikiWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    childAspectRatio: 5 / 2,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20), 
                              itemCount: entries.length,
                              itemBuilder: (BuildContext ctx, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  child: ListTile(
                                                    leading: Image.asset(entries[index].imagePath),
                                                    subtitle: Text("Click For more info"),
                                                    title: Text(entries[index].title),
                                                    onTap: () => openDialog( Image.asset(entries[index].imagePath), 
                                                                            entries[index].title, 
                                                                            entries[index].description)
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius: BorderRadius.circular(20)),
                                                );
                                            }
                            )
    );
  }

  void openDialog(final Image image, final String title, final String description){
    final double ctPadding = 20;
    final double ctAvatarRadius = 45;
    showDialog(context: context, builder: (ctx) {
      return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: ctPadding,top: ctAvatarRadius
                + ctPadding, right: ctPadding,bottom: ctPadding
            ),
            margin: EdgeInsets.only(top: ctAvatarRadius),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(ctPadding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                blurRadius: 10
                ),
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                SizedBox(height: 15,),
                Text(description,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                SizedBox(height: 22,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("Close",style: TextStyle(fontSize: 18),)),
                ),
              ],
            ),
          ),
          Positioned(
            left: ctPadding,
              right: ctPadding,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: ctAvatarRadius,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(ctAvatarRadius)),
                    child: image
                ),
              ),
          ),
        ],
      );  
    });
  }
}