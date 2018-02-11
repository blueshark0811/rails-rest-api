import React, { Component } from 'react';
import PropTypes from 'prop-types';

// import files
import SearchbarTableCourse from './components/SearchbarTableCourse';
import TableCourse from './components/TableCourse';

class FilterableTableCourse extends Component {
  constructor() {
    super();
    this.state = {
      courses: []
    };
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      courses: nextProps.courses
    });
  }

  render() {
    return (
      <div className="FilterableTableCourse">
        <SearchbarTableCourse />
        <TableCourse />
      </div>
    );
  }
}

FilterableTableCourse.propTypes = {
  courses: PropTypes.array.isRequired
};

export default FilterableTableCourse;
