function searchSelect(){
var e = document.getElementById("searchtype");
var schType = e.options[e.selectedIndex].value;
for (var i=0; i < document.searchform.search_type.length; i++)
  {
    if (document.searchform.search_type[i].checked)
	
    {
	  if (document.searchform.search_type[i].value == "Swan"){
		  window.open(['https://catalog.swanlibraries.net/search/?searchtype='+schType+'&SORT=D&searcharg='+document.searchform.catsearchword.value+'&searchscope=50'], "_self");
		  return false;
 	  }
	  else if (document.searchform.search_type[i].value == "Encore"){
	  switch (schType)
	  {
	  case "X":
	  searchType_0 = "";
	  break;
	  case "t":
	  searchType_0 = "t:";
	  break;
	  case "a":
	  searchType_0 = "a:";
	  break;
	  default: 
	  searchType_0 = "";
	  break;
	  }
		  window.open(['http://swanlibraries.net/iii/encore/search/C__S' + searchType_0 + '(' + document.searchform.catsearchword.value + ')__Ff:facetcollections:49:49:Elmwood%252BPark::__Orightresult'], "_self");
		  return false;
         }
	 else {}
      }
	  
   }

}


$(document).ready(function() {
    $('.custom-search .search-links a').on('click', function(e)  {
        var currentAttrValue = $(this).attr('href');
 
        // Show/Hide Tabs
        $('.custom-search ' + currentAttrValue).siblings().slideUp(0);
		$('.custom-search ' + currentAttrValue).delay(0).slideDown(0);
 
        // Change/remove current tab to active
        $(this).parent('li').addClass('active').siblings().removeClass('active');
 
        e.preventDefault();
    });
});


//var $smsearch = jQuery.noConflict();
//$smsearch(document).ready(function(){
//$smsearch( "#navigation2 img" ).click(function() {
//$smsearch( "div.msearch" ).toggle();
//});
//});

