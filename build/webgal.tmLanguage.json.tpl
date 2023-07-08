{
    "$schema": "https://raw.githubusercontent.com/martinring/tmlanguage/master/tmlanguage.json",
    "name": "WebGAL Script",
    "patterns": [
        {
            "include": "#comment-line"
        },
        {
            "include": "#statement"
        }
    ],
    "repository": {
        "argument-list": {
            "patterns": [
                {
                    "comment": "only one argument left, ie kwarg0=val0",
                    "match": "(?!.*\\s\\-).+",
                    "captures": {
                        "0": {
                            "patterns": [
                                {
                                    "include": "#parameter"
                                }
                            ]
                        }
                    }
                },
                {
                    "comment": ">1 arguments left, ie [kwarg0=val0] -[kwarg1=val1]",
                    "match": "(.*?)(\\s\\-)(.*?)$",
                    "captures": {
                        "1": {
                            "patterns": [
                                {
                                    "include": "#parameter"
                                }
                            ]
                        },
                        "2": {
                            "patterns": [
                                {
                                    "include": "#operator"
                                }
                            ]
                        },
                        "3": {
                            "patterns": [
                                {
                                    "include": "#argument-list"
                                }
                            ]
                        }
                    }
                }
            ]
        },
        "character": {
            "match": ".*",
            "name": "entity.name.type.character.webgal"
        },
        "command": {
            "match": ".*",
            "name": "support.function.command.webgal"
        },
        "comment-line": {
            "match": "\\;.*?$",
            "name": "comment.line.webgal"
        },
        "operator": {
            "match": "[\\:\\=\\<\\>\\|\\+\\-]",
            "name": "keyword.operator.webgal"
        },
        "parameter": {
            "patterns": [
                {
                    "comment": "value only, ie val0",
                    "match": "(?!.*\\=).+",
                    "name": "variable.other.webgal"
                },
                {
                    "comment": "name and value, ie [kwarg0]=[val0]",
                    "match": "(.*?)(\\=)(.*?)$",
                    "captures": {
                        "1": {
                            "name": "variable.parameter.webgal"
                        },
                        "2": {
                            "patterns": [
                                {
                                    "include": "#operator"
                                }
                            ]
                        },
                        "3": {
                            "name": "variable.other.webgal"
                        }
                    }
                }
            ]
        },
        "utterance": {
            "patterns": [
                {
                    "comment": "utterance only",
                    "match": "(?!.*\\s\\-)(.+)",
                    "captures": {
                        "0": {
                            "name": "string.unquoted.utterance.webgal"
                        }
                    }
                },
                {
                    "comment": "utterance and argument list",
                    "match": "(.*?)(\\s\\-)(.*?)$",
                    "captures": {
                        "1": {
                            "name": "string.unquoted.utterance.webgal"
                        },
                        "2": {
                            "patterns": [
                                {
                                    "include": "#operator"
                                }
                            ]
                        },
                        "3": {
                            "patterns": [
                                {
                                    "include": "#argument-list"
                                }
                            ]
                        }
                    }
                }
            ]
        },
        "character-colon": {
            "comment": "[char]:[utt[ -args]][;cmt]",
            "match": "^(?!(?:${WEBGAL_CMD})\\:)(.*?)(\\:)([^\\;\\n]*?)($|\\;.*?$)",
            "captures": {
                "1": {
                    "name": "meta.character.webgal",
                    "patterns": [
                        {
                            "include": "#character"
                        }
                    ]
                },
                "2": {
                    "patterns": [
                        {
                            "include": "#operator"
                        }
                    ]
                },
                "3": {
                    "patterns": [
                        {
                            "include": "#utterance"
                        }
                    ]
                },
                "4": {
                    "patterns": [
                        {
                            "include": "#comment-line"
                        }
                    ]
                }
            }
        },
        "command-colon": {
            "comment": "cmd:[arg0[ -args]][;cmt]",
            "match": "^(${WEBGAL_CMD})(\\:)([^\\;\\n]*?)($|\\;.*?$)",
            "captures": {
                "1": {
                    "name": "meta.command.webgal",
                    "patterns": [
                        {
                            "include": "#command"
                        }
                    ]
                },
                "2": {
                    "patterns": [
                        {
                            "include": "#operator"
                        }
                    ]
                },
                "3": {
                    "patterns": [
                        {
                            "include": "#argument-list"
                        }
                    ]
                },
                "4": {
                    "patterns": [
                        {
                            "include": "#comment-line"
                        }
                    ]
                }
            }
        },
        "command-semicolon": {
            "comment": "cmd;[cmt]",
            "match": "^(${WEBGAL_CMD})($|\\;.*?$)",
            "captures": {
                "1": {
                    "name": "meta.command.webgal",
                    "patterns": [
                        {
                            "include": "#command"
                        }
                    ]
                },
                "2": {
                    "patterns": [
                        {
                            "include": "#comment-line"
                        }
                    ]
                }
            }
        },
        "utterance-semicolon": {
            "comment": "utt[ -args];[cmt]",
            "match": "^(?!(?:${WEBGAL_CMD})\\;)([^\\:\\;\\n]+?)(\\;.*?$)",
            "captures": {
                "1": {
                    "patterns": [
                        {
                            "include": "#utterance"
                        }
                    ]
                },
                "2": {
                    "patterns": [
                        {
                            "include": "#comment-line"
                        }
                    ]
                }
            }
        },
        "statement": {
            "patterns": [
                {
                    "include": "#character-colon"
                },
                {
                    "include": "#command-colon"
                },
                {
                    "include": "#command-semicolon"
                },
                {
                    "include": "#utterance-semicolon"
                }
            ]
        }
    },
    "scopeName": "source.webgal"
}