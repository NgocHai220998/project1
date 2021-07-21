document.addEventListener("turbolinks:load",function() {
  x = document.getElementsByClassName("review-modal");

  for(let i = 0; i<x.length; i++) {
    x[i].onclick = function () {
      const recentReview = document.getElementById(`spot-${this.dataset.id}`);
      recentReview.classList.toggle('hidden');
    };
  }

  const tagSelect = document.querySelector('#q_tag_name_in');

  let selectedValues = [];

  function handleSelect(selectedValue){
    let elSelectBox = document.querySelector('.multi-select');
    let selectedHTML = '';

    if (selectedValue && selectedValue.length > 2) {
      document.querySelector('.number-of-count').classList.remove('hidden');
      document.querySelector('.number-of-count span').innerHTML = `... +${selectedValue.length - 2}`;
    } else {
      document.querySelector('.number-of-count').classList.add('hidden');
    }
    if (!selectedValues || (selectedValue && selectedValue.length === 0)) {
      elSelectBox.innerHTML = `<div class="select-item-placeholder">設定なし</div>`;
    } else {
      for(let i=0; i<selectedValue.length; i++) {
        selectedHTML = selectedHTML + `<div class="select-item">${selectedValue[i]}</div>`;
      }
      elSelectBox.innerHTML = selectedHTML;
    }
  }

  const elSelected = document.querySelectorAll('#q_tag_name_in option[selected=selected]');

  if (elSelected && elSelected.length > 0) {
    for (let i = 0; i < elSelected.length; ++i) {
      selectedValues.push(elSelected[i].innerText);
    }
    handleSelect(selectedValues);
  }

  tagSelect.addEventListener('change', (e) => { 
    const options = e.target.options;
    const newSelectedValues = [];

    for (let i = 0; i < options.length; i++) {
      if (options[i].selected) {
        newSelectedValues.push(options[i].value);
        if(!options[i].value) {
          selectedValues = null;
          handleSelect(selectedValues);
          return;
        }
      }
    }
    selectedValues = newSelectedValues
    handleSelect(selectedValues);
  })

  const options = Array.from(document.querySelectorAll('#q_tag_name_in option'));

  options.forEach(function (element) {
    element.addEventListener('mousedown', 
      function (e) {
        if (e.shiftKey) return;
        e.preventDefault();
        tagSelect.focus();
        let scroll = tagSelect.scrollTop;
        e.target.selected = !e.target.selected;
        setTimeout(function(){tagSelect.scrollTop = scroll;}, 0);
        tagSelect.dispatchEvent(new Event('change'));
      }
    , false
    );
  });

  const multiSelect = document.querySelector('.multi-select');

  multiSelect.onclick = function (){
    document.querySelector('#q_tag_name_in').classList.toggle('hidden');
  };
});
