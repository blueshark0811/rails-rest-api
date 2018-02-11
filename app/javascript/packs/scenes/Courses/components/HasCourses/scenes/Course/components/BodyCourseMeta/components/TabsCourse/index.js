import React from 'react';
import PropTypes from 'prop-types';
import { Tab } from 'react-bootstrap';

import Tabs from 'base_components/Tabs';
import ItemListTutorials from './components/ItemListTutorials';
import ItemTableTutorialsFile from './components/ItemTableTutorialsFile';
import ItemTableGroupDiscussions from './components/ItemTableGroupDiscussions';

class TabsCourse extends React.Component {
  shouldComponentUpdate(nextProps) {
    // if not the same, re-render the components
    if (this.props.course !== nextProps.course) {
      return true;
    }

    return false;
  }
  render() {
    // get the list tutorials for this course
    const { tutorials, files } = this.props.course;

    return (
      <Tabs style={this.props.style}>
        <Tab eventKey={1} title="Tutorials">
          <ItemListTutorials tutorials={tutorials} />
        </Tab>
        <Tab eventKey={2} title="Group Discussions">
          <ItemTableGroupDiscussions />
        </Tab>
        <Tab eventKey={3} title="Files">
          <ItemTableTutorialsFile files={files} />
        </Tab>
      </Tabs>
    );
  }
}

TabsCourse.propTypes = {
  style: PropTypes.object
};

export default TabsCourse;
