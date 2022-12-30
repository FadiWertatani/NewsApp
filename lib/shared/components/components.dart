import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article) => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image:  DecorationImage(
            image: NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 20.0),
      Expanded(
        child: SizedBox(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index]),
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: list.length,
  ),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);