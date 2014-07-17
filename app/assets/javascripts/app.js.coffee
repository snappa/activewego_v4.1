$( document ).ready ->
  $('#counter').text('140')
  $('#micropost_content').keyup ->
#      tempStr = ""
      tempStr = $(this).val()
      if tempStr.length > 0
        if tempStr.charCodeAt(tempStr.length - 1) == 10 ||
           tempStr.charCodeAt(tempStr.length - 1) == 13
          alert "CR or LF not allowed"
          $(this).val( $(this).val().substring(0, $(this).val().length - 1) )
#        alert "TempStr: " + tempStr.charCodeAt(tempStr.length - 1)
          return

      left = 140 - $(this).val().length
      if left < 0
          first140 = $(this).val().substring(0, 140)
          alert("You can only use at most 140 characters.  Message has been truncated to 140 characters.  Please check before submitting.")

          $(this).val(first140)
          left = 0
      
      $('#counter').html(left)
    
