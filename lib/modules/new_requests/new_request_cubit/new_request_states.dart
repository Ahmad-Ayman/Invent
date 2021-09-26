abstract class NewRequestStates {}

class NewRequestInitState extends NewRequestStates {}

class NewRequestsGetAllPharmaciesLoadingState extends NewRequestStates {}

class NewRequestsGetAllPharmaciesSuccessState extends NewRequestStates {}

class NewRequestsGetAllPharmaciesFailedState extends NewRequestStates {}

class NewRequestTokenExpiredState extends NewRequestStates {}

class NewRequestsGetAllChainsLoadingState extends NewRequestStates {}

class NewRequestsGetAllChainsSuccessState extends NewRequestStates {}

class NewRequestsGetAllChainsFailedState extends NewRequestStates {}

class PharmaciesSearchLoadingState extends NewRequestStates {}

class PharmaciesSearchSuccessState extends NewRequestStates {}

class PharmaciesSearchErrorState extends NewRequestStates {}
