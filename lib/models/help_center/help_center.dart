/*
import 'package:flutter/material.dart';


class HelpCenterQuestions {
  HelpCenterQuestions({this.question="", this.answer="", this.isExpanded=false});

  bool isExpanded;
  final String question;
  final String answer;
}

class HelpCenterTopics{
  HelpCenterTopics({this.topic="", this.listQuestions = const <HelpCenterQuestions>[],this.isExpanded=false});

  bool isExpanded;
  final String topic;
  final List<HelpCenterQuestions> listQuestions ;
}

List<HelpCenterTopics> helpCenterTopics = <HelpCenterTopics>[
  HelpCenterTopics(topic:"Tittle 1", listQuestions : helpCenterQuestion1),
  HelpCenterTopics(topic:"Tittle 2", listQuestions : helpCenterQuestion2),
  HelpCenterTopics(topic:"Tittle 3", listQuestions : helpCenterQuestion3),
];

List<HelpCenterQuestions> helpCenterQuestion1 = <HelpCenterQuestions>[
  HelpCenterQuestions(question:" Titele 1 Header 1", answer:"This is first description "),
  HelpCenterQuestions(question:" Titele 1 Header 2", answer:"This is second description "),
  HelpCenterQuestions(question:" Titele 1 Header 3", answer:"This is third description "),
];

List<HelpCenterQuestions> helpCenterQuestion2 = <HelpCenterQuestions>[
  HelpCenterQuestions(question:" Titele 2 Header 1", answer:"Tilele 2 Header 1 description "),
  HelpCenterQuestions(question:" Titele 2 Header 2", answer:"Tilele 2 Header 2 description "),
  HelpCenterQuestions(question:" Titele 2 Header 3", answer:"Tilele 2 Header 3 description "),
];

List<HelpCenterQuestions> helpCenterQuestion3 = <HelpCenterQuestions>[
  HelpCenterQuestions(question:" Titele 3 Header 1", answer:"Natural"),
  HelpCenterQuestions(question:" Titele 3 Header 2", answer:"How u like that <3"),
];*/

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class HelpCenterQuestion {
  String question;
  String answer;
  bool isExpanded = false;

  HelpCenterQuestion({
    required this.question,
    required this.answer,
  });

  HelpCenterQuestion copyWith({
    String?question,
    String?answer,
  }) {
    return HelpCenterQuestion(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
    };
  }

  factory HelpCenterQuestion.fromMap(Map<String, dynamic> map){
   /* print(map['question']);
    print(map['answer']);*/
    return HelpCenterQuestion(
      question: map['question'],
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HelpCenterQuestion.formJson(String source) =>
      HelpCenterQuestion.fromMap(json.decode(source));

  @override
  String toString() =>
      'HelpCenterQuestion(question: $question, answer: $answer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HelpCenterQuestion &&
        other.question == question &&
        other.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;

}

class HelpCenterTopic {
  String topicID;
  String tittle;
  bool isExpanded = false;
  List<HelpCenterQuestion> listQuestions;

  HelpCenterTopic({
    required this.topicID,
    required this.tittle,
    required this.listQuestions,
  });

  HelpCenterTopic copyWith({
    String?topicID,
    String?tittle,
    List<HelpCenterQuestion>?listQuestions,
  }) {
    return HelpCenterTopic(
        topicID: topicID ?? this.topicID,
        tittle: tittle ?? this.tittle,
        listQuestions: listQuestions ?? this.listQuestions);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': topicID,
    };
  }



  factory HelpCenterTopic.fromMap(Map<String, dynamic> map){

    final helpCenterQuestion =map['listQuestionAndAnswer'] as List ;
    //print(map['topicName']);
    List<HelpCenterQuestion> helpCenterQuestionList = helpCenterQuestion.map((helpCenterQuestion) => HelpCenterQuestion.fromMap(helpCenterQuestion)).toList();
    //print(helpCenterQuestionList);
    return HelpCenterTopic(
        topicID: map['_id'],
        tittle: map['topicName'],
        listQuestions:helpCenterQuestionList,
    );
  }

  String toJson() => json.encode(toMap());

  factory HelpCenterTopic.fromJson(String source)=>
      HelpCenterTopic.fromMap(json.decode(source));

  @override
  String toString() => 'HelpCenterTopic(topicID: $topicID, tittle:$tittle)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HelpCenterTopic &&
        other.topicID == topicID &&
        other.tittle == tittle;
  }

  @override
  int get hashCode => topicID.hashCode ^ tittle.hashCode;


}

