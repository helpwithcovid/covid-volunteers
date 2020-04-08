import React from "react";

const BtnFilter = props => {
  const { filterFunc, val, facetType } = props;
  return (
    <button
      onClick={() => filterFunc({ val, facetType })}
      className="outline-none inline-flex items-center px-2 py-1 mt-2 mr-2 rounded-md text-sm font-medium leading-5 flex-grow-0 bg-indigo-100 text-indigo-800 "
    >
      <svg
        className="ml-1 mr-2 h-2 w-2 text-indigo-400"
        fill="currentColor"
        viewBox="0 0 8 8"
      >
        <circle cx="4" cy="4" r="3"></circle>
      </svg>
      {val}
    </button>
  );
};
export default BtnFilter;
