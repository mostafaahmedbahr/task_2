abstract class SearchStates{}

class SearchInitState extends SearchStates{}

class SearchLoaded extends SearchStates{}

class GetAllBooksListLoadingState extends SearchStates{}
class GetAllBooksListSuccessState extends SearchStates{}
class GetAllBooksListErrorState extends SearchStates{}