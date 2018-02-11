import React from 'react';
import PropTypes from 'prop-types';

// sub-components
import TutorialTaskPanelHeader from './components/TutorialTaskPanelHeader';
import TutorialTaskPanelContent from './components/TutorialTaskPanelContent';

class TutorialTaskPanel extends React.Component {
  constructor() {
    super();
    this.state = {
      isPanelOpen: false
    };
  }
  handleTogglePanel = e => {
    e.preventDefault();
    // update the state
    this.setState({
      isPanelOpen: !this.state.isPanelOpen
    });
  };
  render() {
    const { category, title, children, isReadingGroup } = this.props;
    return (
      <div style={tutorialTaskPanelStyle} className="TutorialTaskPanel">
        <TutorialTaskPanelHeader
          isPanelOpen={this.state.isPanelOpen}
          handleTogglePanel={this.handleTogglePanel}
          category={category}
          title={title}
          isReadingGroup={isReadingGroup}
        />
        <TutorialTaskPanelContent isPanelOpen={this.state.isPanelOpen}>
          {children}
        </TutorialTaskPanelContent>
      </div>
    );
  }
}

TutorialTaskPanel.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.element),
    PropTypes.element
  ]).isRequired,
  category: PropTypes.string.isRequired,
  title: PropTypes.string.isRequired,
  isReadingGroup: PropTypes.bool
};

// default props
TutorialTaskPanel.defaultProps = {
  isReadingGroup: false
};

const tutorialTaskPanelStyle = {
  border: '1px solid #cbcbcb',
  borderRadius: 4,
  marginBottom: '1em'
};

export default TutorialTaskPanel;
