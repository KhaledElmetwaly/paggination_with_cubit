part of 'view.dart';

class _Item extends StatelessWidget {
  final MovieModel model;
  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MovieDetailsView(id: model.id),
        //     ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).primaryColor.withOpacity(.1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Image.network(
                  model.image,
                  height: 200,
                  fit: BoxFit.cover,
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      model.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          model.voteAverage.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.orange),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
