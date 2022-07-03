import 'package:charity/model/phoneNumber.dart';
import 'package:charity/screens/SearchDisplayScreen.dart';
import 'package:charity/screens/phoneNumbersScreen.dart';
import 'package:flutter/material.dart';

class SubjectSearch extends SearchDelegate<PhoneNumber>
{

  // Subjects sub;
  // SubjectSearch(this.sub);
  final List<String> _history=[];
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //return ListOfPdfs(subname: this.query.toUpperCase(),route:'search');
    return SearchDisplayScreen(this.query.trim());
    //return phoneNumbersScreen();
  }
  @override
  Widget buildSuggestions(BuildContext context) {
  final subList=PhoneNumbers.allofthem.map((sub)=>sub.number).toList();
  final Iterable<String> suggestions = this.query.isEmpty
        ?_history
        : subList.where((sub) => sub.startsWith(query.toString()));
  print(suggestions);
    return _SubjectSuggestionList(
      query: this.query,
      suggestions: suggestions,
      onSelected: (String suggestion) {
        this.query = suggestion;
       
      // this._history.insert(0, suggestion);
        showResults(context);
      },
    );
  }
  
}
// Suggestions list widget displayed in the search page.
class _SubjectSuggestionList extends StatelessWidget {
  const _SubjectSuggestionList({this.suggestions, this.query, this.onSelected});
  final suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions.elementAt(i);
        return Container(
          color: PhoneNumbers.givenList.contains(PhoneNumbers.getObject(suggestion)) ? Colors.red : Colors.white,
          child: ListTile(
            
            leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(PhoneNumbers.getObject(suggestion).serialNumber.toString()),
                    ),
            // Highlight the substring that matched the query.
            title: RichText(
              text: TextSpan(
                text: suggestion.substring(0, query.length),
                style: textTheme.copyWith(fontWeight: FontWeight.bold,color:  PhoneNumbers.givenList.contains(PhoneNumbers.getObject(suggestion)) ? Colors.white : Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: suggestion.substring(query.length),
                    style: textTheme,
                  ),
                ],
              ),
            ),
            onTap: () {
              onSelected(suggestion);
            },
          ),
        );
      },
    );
  }
}