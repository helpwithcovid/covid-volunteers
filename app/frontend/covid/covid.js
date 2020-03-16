const covid = {

  initialize() {
    incrementNode.addEventListener('click', (event) => {
      event.preventDefault();
      const currentValue = inputNode.value;
      inputNode.value = parseInt(currentValue, 0) + 1;
    });

    decrementNode.addEventListener('click', (event) => {
      event.preventDefault();
      const currentValue = inputNode.value;
      if (currentValue > 0) {
        inputNode.value = parseInt(currentValue, 0) - 1;
      }
    });
  }
};
  
export default covid;
